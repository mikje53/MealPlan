module Main exposing (..)

import Browser 
import Html exposing (Html, div, text, ul, li)

main =
    Browser.sandbox { init = 0, update = update, view = view }

type Msg =
    Increment

update msg model =
    case msg of
        Increment -> 1

toHtmlMsg : String -> (Html li)
toHtmlMsg element = 
    li [] ( [ text element ] )

type Method = Method String
type Serves = Int
type Time = Time String
type Ingredients = List ( String )
type Recipe = {
    
}


view model = 
    let 
        ingredients = 
            ["20 g flour",
            "50 ml milk"]
        
        method = "Do this. Then do that."

        serves = 6

        time = "1h 10min"

        ingredientsAsHtml : List ( Html Msg ) 
        ingredientsAsHtml = 
            List.map toHtmlMsg ( ingredients )
    in
    div []
        [ div [] [ text "Ingredients:" ]
        , ul [] ingredientsAsHtml
        , div [] [ text "Method: "]
        , div [] [ text method ]
        , div [] [ text ( "Serves: " ++ String.fromInt serves ) ]
        , div [] [ text ( "Time to do it: " ++ time )]
        ]
        
    
    