module Board exposing (..)

import Html exposing(..)
import Http
import Json.Decode as Decode
import Models exposing (Board, Column, initialBoardModel)

-- MAIN

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }







-- MODEL

type alias Model =
    { board : Board
    , columnsList : List Column
    , errors : String
    }

initialModel : Model
initialModel =
    { board = initialBoardModel
    , columnsList = []
    , errors = ""
    }

initialCommand : Cmd Msg
initialCommand =
    Cmd.batch
    [ fetchBoard
    ]

-- INIT

init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCommand )





-- Board
fetchBoard : Cmd Msg
fetchBoard = 
    Http.get "/api/boards/2" decodeBoard
        |> Http.send FetchBoard

decodeBoard : Decode.Decoder Board
decodeBoard = 
    Decode.field "data" (
        Decode.map3 Board
            (Decode.field "id" Decode.int)
            (Decode.field "name" Decode.string)
            (Decode.field "user_id" Decode.int)
    )



-- UPDATE

type Msg
    = FetchBoard (Result Http.Error (Board))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchBoard result ->
            case result of
                Ok newBoard ->
                    ( { model | board = newBoard }, Cmd.none )
                Err message ->
                    ( { model | errors = toString message }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ boardMenu model
        ]


boardMenu : Model -> Html msg
boardMenu model =
    div [] [ text model.board.name ]
