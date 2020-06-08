

event zeek_init()
    {
    # Create the logging stream.
    print "Starting packet filter.";
    }
    
event new_packet(c:connection, h:pkt_hdr)
    { 
    local subNet = to_subnet(getenv("THIS_SUBNET"));
    local src = mask_addr(h$ip$src, 24);
    local dst = mask_addr(h$ip$dst, 24);
    local subIp = subnet_to_addr(subNet);
   
    if (subNet != src && subNet != dst) {    
        print "dropping packet", h$ip$src;
        install_src_addr_filter(h$ip$src, 0, 1);
    }
    }
