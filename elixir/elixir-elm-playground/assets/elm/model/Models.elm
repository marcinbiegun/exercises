module Models exposing (..)

type alias Board =
    { id : Int
    , name : String
    , user_id : Int
    }

type alias Column =
    { id : Int
    , name : String
    , weight : Int
    , board_id : Int
    }

type alias Task =
    { id : Int
    , name : String
    , description : Maybe String
    , weight : Int
    , is_done : Bool
    , column_id : Int
    }

initialBoardModel : Board
initialBoardModel =
    { id = 0
    , name = ""
    , user_id = 0
    }