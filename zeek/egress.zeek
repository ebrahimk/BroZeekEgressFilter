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
    local subNet = to_subnet(getenv("THIS_SUBNET"));
    local src = mask_addr(h$ip$src, 24);
    local dst = mask_addr(h$ip$dst, 24);
    local subIp = subnet_to_addr(subNet);
   
    if (subNet != src && subNet != dst) {
        # if neither match, then the spoofed src address needs to be blocked
        install_src_addr_filter(h$ip$src, 0, 1);
        
        return T;
    }
    
    return F; 
}
