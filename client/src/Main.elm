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

toListItem : String -> (Html li)
toListItem element = 
    li [] ( [ text element ] )

type alias Method = String
type alias Serves = Int
type alias Time = String
type alias Ingredients = List ( String )
type alias Name = String

type alias Recipe = { name: Name
    , method: Method
    , ingredients: Ingredients
    , serves: Serves
    , time: Time }

recipes : List(Recipe)
recipes = [Recipe 
    "First recipe"
    "Do this and that"
    ["flour", "milk"]
    2
    "20 min"
    , Recipe "Second recipe" "Do Something" ["stone"] 3 "5 min"]

getName : Recipe -> Name
getName recipe =
    recipe.name

view model = 
    let 
        recipeNames : List ( Html Msg )
        recipeNames = 
            recipes 
            |> List.map getName
            |> List.map toListItem
        

    in
    div []
        [ text "Recipes:"
        , ul [] recipeNames ]
        
    
    