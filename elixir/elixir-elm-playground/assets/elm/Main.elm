module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode
import Models exposing (Board, Column, Task)

-- Boards
fetchBoardsList : Cmd Msg
fetchBoardsList = 
    Http.get "/api/boards" decodeBoardsList
        |> Http.send FetchBoardsList

decodeBoardsList : Decode.Decoder (List Board)
decodeBoardsList =
    decodeBoard
        |> Decode.list
        |> Decode.at [ "data" ]

decodeBoard : Decode.Decoder Board
decodeBoard = 
    Decode.map3 Board
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "user_id" Decode.int)


-- Columns
fetchColumnsList : Cmd Msg
fetchColumnsList = 
    Http.get "/api/columns" decodeColumnsList
        |> Http.send FetchColumnsList

decodeColumnsList : Decode.Decoder (List Column)
decodeColumnsList =
    decodeColumn
        |> Decode.list
        |> Decode.at [ "data" ]

decodeColumn : Decode.Decoder Column
decodeColumn = 
    Decode.map4 Column
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "weight" Decode.int)
        (Decode.field "board_id" Decode.int)


-- Task
fetchTasksList : Cmd Msg
fetchTasksList = 
    Http.get "/api/tasks" decodeTasksList
        |> Http.send FetchTasksList

decodeTasksList : Decode.Decoder (List Task)
decodeTasksList =
    decodeTask
        |> Decode.list
        |> Decode.at [ "data" ]

decodeTask : Decode.Decoder Task
decodeTask = 
    Decode.map6 Task
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.maybe (Decode.field "description" Decode.string))
        (Decode.field "weight" Decode.int)
        (Decode.field "is_done" Decode.bool)
        (Decode.field "column_id" Decode.int)



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
    { boardsList : List Board
    , columnsList : List Column
    , tasksList : List Task
    , errors : String
    }


initialModel : Model
initialModel =
    { boardsList = []
    , columnsList = []
    , tasksList = []
    , errors = ""
    }


initialCommand : Cmd Msg
initialCommand =
    Cmd.batch
    [ fetchBoardsList
    , fetchColumnsList
    , fetchTasksList
    ]



-- INIT


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCommand )



-- UPDATE

type Msg
    = FetchBoardsList (Result Http.Error (List Board))
    | FetchColumnsList (Result Http.Error (List Column))
    | FetchTasksList (Result Http.Error (List Task))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchBoardsList result ->
            case result of
                Ok boards ->
                    ( { model | boardsList = boards }, Cmd.none )
                Err message ->
                    ( { model | errors = toString message }, Cmd.none )
        FetchColumnsList result ->
            case result of
                Ok columns ->
                    ( { model | columnsList = columns }, Cmd.none )
                Err message ->
                    ( { model | errors = toString message }, Cmd.none )
        FetchTasksList result ->
            case result of
                Ok tasks ->
                    ( { model | tasksList = tasks }, Cmd.none )
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
        [ boardsIndex model
        , columnsIndex model
        , tasksIndex model
        ]



-- Boards view
boardsIndex : Model -> Html msg
boardsIndex model =
    if List.isEmpty model.boardsList then
        div [] [ text "no boards to display" ]
    else
        div []
        [ h1 [ class "boards-section" ] [ text "Boards" ]
        , boardsList model.boardsList
        ]

boardsList : List Board -> Html msg
boardsList boards =
    ul [ class "boards-list" ] (List.map boardsListItem boards)

boardsListItem : Board -> Html mst
boardsListItem board =
    li [ class "board-item" ]
        [ strong [] [ text board.name ]
        , p [] [ text ("ID: " ++ toString board.id) ]
        ]


-- Columns view
columnsIndex : Model -> Html msg
columnsIndex model =
    if List.isEmpty model.columnsList then
        div [] [ text "no columns to display" ]
    else
        div []
        [ h1 [ class "columns-section" ] [ text "Columns" ]
        , columnsList <|
            columnsSortedByWeight model.columnsList
        ]

columnsSortedByWeight : List Column -> List Column
columnsSortedByWeight columns =
    columns
        |> List.sortBy .weight

columnsList : List Column -> Html msg
columnsList columns =
    ul [ class "columns-list" ] (List.map columnsListItem columns)

columnsListItem : Column -> Html mst
columnsListItem column =
    li [ class "column-item" ]
        [ strong [] [ text column.name ]
        , p [] [ text ("ID: " ++ toString column.id) ]
        ]

-- Tasks view
tasksIndex : Model -> Html msg
tasksIndex model =
    if List.isEmpty model.tasksList then
        div [] [ text "no tasks to display" ]
    else
        div []
        [ h1 [ class "tasks-section" ] [ text "Tasks" ]
        ,  tasksList <|
            tasksSortedByWeight model.tasksList
        ]

tasksSortedByWeight : List Task -> List Task
tasksSortedByWeight tasks =
    tasks
        |> List.sortBy .weight

tasksList : List Task -> Html msg
tasksList tasks =
    ul [ class "tasks-list" ] (List.map tasksListItem tasks)

tasksListItem : Task -> Html mst
tasksListItem task =
    li [ class "task-item" ]
        [ strong [] [ text task.name ]
        , p [] [ text ("ID: " ++ toString task.id) ]
        , p [] [ text ("Description: " ++ Maybe.withDefault "- no description -" task.description) ]
        , p [] [ text ("Weight: " ++ toString task.weight) ]
        ]
