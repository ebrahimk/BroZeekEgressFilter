module Egress;

export {
    # Append the value LOG to the Log::ID enumerable.
    redef enum Log::ID += { LOG };

    # Define a new type called Factor::Info.
    type Info: record {
        num:            count &log;
        source:         addr &log;
        destination:    addr &log;  
        spoofed:        bool &log;
        };
    global egress_filter: function(h: pkt_hdr): bool;
    }
    

function egress_filter(h: pkt_hdr): bool
    {
    local l = to_addr(getenv("LOCAL_IP"));
    if (l != h$ip$src && l != h$ip$dst) {
        return T;
    }
    return F; 
    }
