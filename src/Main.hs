{-# LANGUAGE CPP           #-}
{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeFamilies  #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import           Data.Aeson
import           Data.Time.Calendar
import           GHC.Generics
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant

data User = User
    { name              :: String
    , email             :: String
    , registration_date :: Day
    } deriving (Eq, Show, Generic)

instance ToJSON Day where
    toJSON d = toJSON (showGregorian d)

instance ToJSON User

users :: [User]
users =
    [ User "Jim Sandridge" "hero@unikernel.com" (fromGregorian 2015 11 20)
    , User "Tim Ferrell" "pooppoop@unicorn.com" (fromGregorian 2015 11 20)]

type UserAPI = "users" :> Get '[JSON] [User]

userAPI :: Proxy UserAPI
userAPI = Proxy

server :: Server UserAPI
server = return users

app :: Application
app = serve userAPI server

main :: IO ()
main = run 8081 app
