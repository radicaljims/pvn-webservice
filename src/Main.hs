module Main where

import Network.Wai.Handler.Warp    (run)
import System.Environment          (lookupEnv)
import Database.Persist.Postgresql (runSqlPool)

import Config (defaultConfig, Config(..), Environment(..), setLogger, makePool)
import Api (app)
-- import Api    (app, apiJS)
import Models (doMigrations)

-- import           Servant.JS
-- import qualified Servant.JS                  as SJS
-- import qualified Servant.JS.Angular          as NG

main :: IO ()
main = do

    -- writeJSForAPI userAPI (angular defAngularOptions) (www </> "angular" </> "api.js")
    -- writeServiceJS (www </> "angular" </> "api.service.js")

    -- writeFile "content/api.js" apiJS
    env  <- lookupSetting "ENV" Development
    port <- lookupSetting "PORT" 8081
    pool <- makePool env
    let cfg = defaultConfig { getPool = pool, getEnv = env }
        logger = setLogger env
    runSqlPool doMigrations pool
    run port $ logger $ app cfg


lookupSetting :: Read a => String -> a -> IO a
lookupSetting env def = do
    p <- lookupEnv env
    return $ case p of Nothing -> def
                       Just a  -> read a
