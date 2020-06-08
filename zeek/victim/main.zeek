@load egress
@load policy/tuning/json-logs.zeek

global pkt_count = 0;

event zeek_init()
    {
    # Create the logging stream.
    Log::create_stream(Egress::LOG, [$columns=Egress::Info, $path="egress"]);
    }
    
event new_packet(c:connection, h:pkt_hdr)
    { 
    pkt_count += 1;
    Log::write( Egress::LOG, [$num=pkt_count, $source_ip=h$ip$src, 
                                $destination_ip=h$ip$dst, $spoofed=Egress::egress_filter(h)]);
    }
