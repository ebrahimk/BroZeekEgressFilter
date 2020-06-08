module Victim;

export {
    # Append the value LOG to the Log::ID enumerable.
    redef enum Log::ID += { LOG };

    # Define a new type called Factor::Info.
    type Info: record {
        num:            count &log;
        source_ip:         addr &log;
        destination_ip:    addr &log;  
        };
    }
    

