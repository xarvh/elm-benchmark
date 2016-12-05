
import Html
import Sha256
import Task
import Time exposing (Time)


type alias Model =
    { start : Time
    , message : String
    }

init =
    { start = 0
    , message = ""
    }

type Msg
    = TimerStarts Time
    | TimerStops Time



theString =
    """
    laskjldf lakj;ld 
    aldkjflkj alkh a
    lkjasdh 
    adlkfjh 
    ad;h adoiyr;lnzxclkp984w
    """



update msg model =
    case msg of
        TimerStarts time ->
            let
                makeSha _ =
                    Sha256.sha256 theString

                shas =
                    List.repeat 1000 "" |> List.map makeSha
            in
                { model | start = time } ! [Task.perform TimerStops Time.now]

        TimerStops time ->
            { model | message = toString (time - model.start) } ! []


main =
    Html.program
        { init = ( init, Task.perform TimerStarts Time.now )
        , view = \model -> Html.text model.message
        , update = update
        , subscriptions = \model -> Sub.none
        }
