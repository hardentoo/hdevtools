module Types
    ( ServerDirective(..)
    , ClientDirective(..)
    , Command(..)
    , CommandExtra(..)
    , emptyCommandExtra
    ) where

import System.Exit (ExitCode)

data CommandExtra = CommandExtra
  { ceGhcOptions  :: [String]
  , ceCabalConfig :: Maybe FilePath
  , cePath        :: Maybe FilePath
  } deriving (Read, Show)

emptyCommandExtra :: CommandExtra
emptyCommandExtra = CommandExtra { ceGhcOptions  = []
                                 , ceCabalConfig = Nothing
                                 , cePath        = Nothing
                                 }

data ServerDirective
    = SrvCommand Command CommandExtra
    | SrvStatus
    | SrvExit
    deriving (Read, Show)

data ClientDirective
    = ClientStdout String
    | ClientStderr String
    | ClientExit ExitCode
    | ClientUnexpectedError String -- ^ For unexpected errors that should not happen
    deriving (Read, Show)

data Command
    = CmdCheck FilePath
    | CmdModuleFile String
    | CmdInfo FilePath String
    | CmdType FilePath (Int, Int)
    deriving (Read, Show)
