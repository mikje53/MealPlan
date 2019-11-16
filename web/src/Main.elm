module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, li, text, ul)
import Html.Attributes exposing (..)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = subscriptions
        }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , recipe : Maybe Recipe
    }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


toListItem : String -> Html msg
toListItem element =
    li [] [ a [ href element ] [ text element ] ]


type alias Method =
    String


type alias Serves =
    Int


type alias Time =
    String


type alias Ingredients =
    List String


type alias Name =
    String


type alias Recipe =
    { name : Name
    , method : Method
    , ingredients : Ingredients
    , serves : Serves
    , time : Time
    }


recipes : List Recipe
recipes =
    [ Recipe
        "First recipe"
        "Do this and that"
        [ "flour", "milk" ]
        2
        "20 min"
    , Recipe "Second recipe" "Do Something" [ "stone" ] 3 "5 min"
    ]


getName : Recipe -> Name
getName recipe =
    recipe.name


view : Model -> Browser.Document Msg
view model =
    let
        recipeNames : List (Html Msg)
        recipeNames =
            recipes
                |> List.map getName
                |> List.map toListItem
    in
    { title = "Meal plan"
    , body =
        [ div []
            [ text "Recipes:"
            , ul [] recipeNames
            ]
        ]
    }
