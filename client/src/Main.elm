module Main exposing (..)

import Browser 
import Html exposing (Html, div, text)

main =
    Browser.sandbox { init = 0, update = update, view = view }

type Msg =
    Increment

update msg model =
    case msg of
        Increment -> 1


view model = 
    div []
        [ text "Hello world" ]