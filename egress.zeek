event new_packet(c:connection, h:pkt_hdr)
    {
    local l = to_addr(getenv("LOCAL_IP"));
    #print l;
    if (l != h$ip$src && l != h$ip$dst) 
        {
        print "bad packet found";
        print h$ip$src;
        print h$ip$dst;
        } 
    }
