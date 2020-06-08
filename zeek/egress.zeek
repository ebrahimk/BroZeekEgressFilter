module Egress;

export {
    # Append the value LOG to the Log::ID enumerable.
    redef enum Log::ID += { LOG };

    # Define a new type called Factor::Info.
    type Info: record {
        num:            count &log;
        source_ip:         addr &log;
        destination_ip:    addr &log;  
        spoofed:        bool &log;
        };
    global egress_filter: function(h: pkt_hdr): bool;
    }
    

function egress_filter(h: pkt_hdr): bool
{
    local subNet = to_subnet(getenv("THIS_SUBNET"));
    local src = mask_addr(h$ip$src, 24);
    local dst = mask_addr(h$ip$dst, 24);
    local subIp = subnet_to_addr(subNet);
   
    if (subNet != src && subNet != dst) {    
        return T;
    }
    
    return F; 
}
