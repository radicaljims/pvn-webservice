{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module Api where

import           Control.Monad.Reader        (ReaderT, lift, runReaderT)
-- import           Control.Monad.Trans.Either  (EitherT, left)
import           Control.Monad.Trans.Except  (ExceptT, throwE)
import           Data.Int                    (Int64)
import           Database.Persist.Postgresql (Entity (..), fromSqlKey, insert,
                                              selectList, (==.))
import           Network.Wai                 (Application)
import           Servant
-- import           Servant.JQuery

import           Config                      (Config (..))
import           Models

type PersonAPI =
         "users" :> Get '[JSON] [Person]
    :<|> "users" :> Capture "name" String :> Get '[JSON] Person
    :<|> "users" :> ReqBody '[JSON] Person :> Post '[JSON] Int64

type API = PersonAPI :<|> Raw

type AppM = ReaderT Config (ExceptT ServantErr IO)

userAPI :: Proxy PersonAPI
userAPI = Proxy

api :: Proxy API
api = Proxy

server :: ServerT PersonAPI AppM
server = allPersons :<|> singlePerson :<|> createPerson

www :: FilePath
www = "content"

readerServer :: Config -> Server API
readerServer cfg = enter (readerToEither cfg) server :<|> serveDirectory www

readerToEither :: Config -> AppM :~> ExceptT ServantErr IO
readerToEither cfg = Nat $ \x -> runReaderT x cfg

app :: Config -> Application
app cfg = serve api (readerServer cfg)

allPersons :: AppM [Person]
allPersons = do
    users <- runDb $ selectList [] []
    let people = map (\(Entity _ y) -> userToPerson y) users
    return people

singlePerson :: String -> AppM Person
singlePerson str = do
    users <- runDb $ selectList [UserName ==. str] []
    let list = map (\(Entity _ y) -> userToPerson y) users
    case list of
         []     -> lift $ throwE err404
         (x:xs) -> return x

createPerson :: Person -> AppM Int64
createPerson p = do
    newPerson <- runDb $ insert $ User (name p) (email p) (registrationDate p)
    return $ fromSqlKey newPerson

-- apiJS :: String
-- apiJS = jsForAPI userAPI
