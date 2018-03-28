<cfscript>

    private string function getDateTimeMessage( required date dateCreated ) output=false {
        var currentDateTime      = now();
        var dateTimeMessage      = "";
        var rangeToCompare       = "s,n,h,d,w,m,yyyy";
        var rangeToCompareLabel  = "second,minute,hour,day,week,month,year";
        var differentRange       = "60,60,24,7,4,12,1";
        var differentDirection   = "lt,lt,lt,lt,lt,lt,gt";
        var i = 1;
        var past = false;

        if( currentDateTime GT arguments.dateCreated ){
            past = true;
        }

        loop list=rangeToCompare index="indexRange"{
            var different        = dateDiff(  indexRange, arguments.dateCreated, currentDateTime );
            var differentCompare = listGetAt( differentRange      , i ); //60
            var compareDirection = listGetAt( differentDirection  , i ); //lt
            var rangeLabel       = listGetAt( rangeToCompareLabel , i ); //second

            if( !past ){
                different = dateDiff(  indexRange, currentDateTime, arguments.dateCreated );
            }

            if( compareDirection EQ 'lt' ){
                validCompare = different LTE differentCompare;
            }else if( compareDirection EQ 'gt' ){
                validCompare = different GT differentCompare;
            }

            if( validCompare ){
                if( different GT 1){
                    rangeLabel = rangeLabel & 's';
                }
                if( past ){
                    rangeLabel &= ' ago';
                }else{
                    rangeLabel &= ' to go';
                }
                dateTimeMessage = different & ' ' & rangeLabel;
                break;
            }

            i++;
        }

        return dateTimeMessage;
    }

</cfscript>