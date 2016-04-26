{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Models where

import           Control.Monad.Reader        (ReaderT, asks, liftIO)
import           Data.Aeson
import           Data.Text
import           Data.Time.Calendar
import           Data.Time.Clock
import           Data.Time.Format
import           Database.Persist.Postgresql (SqlBackend (..), runMigration,
                                              runSqlPool)
import           Database.Persist.TH         (mkMigrate, mkPersist,
                                              persistLowerCase, share,
                                              sqlSettings)
import           GHC.Generics                (Generic)

import           Config

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
    name String
    email String
    registrationDate Day
    deriving Show
|]

doMigrations :: ReaderT SqlBackend IO ()
doMigrations = runMigration migrateAll

runDb query = do
    pool <- asks getPool
    liftIO $ runSqlPool query pool

data Person = Person
    { name             :: String
    , email            :: String
    , registrationDate :: Day
    } deriving (Eq, Show, Generic)


-- instance FromJSON Day where
--     parseJSON = withText "Day" $ \t ->
--         case parseTime defaultTimeLocale "%F" (unpack t) of
--             Just d -> pure d
--             _      -> fail "could not parse ISO-8601 date"

-- instance ToJSON Day where
--     toJSON t = String $ pack $ formatTime defaultTimeLocale format t
--         where
--             format = "%F"

instance ToJSON Person
instance FromJSON Person

userToPerson :: User -> Person
userToPerson User{..} = Person { name = userName, email = userEmail, registrationDate = userRegistrationDate }
