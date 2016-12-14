let x = 
      Printexc.record_backtrace true;
      Gc.set { (Gc.get()) with Gc.minor_heap_size = 1048576; Gc.major_heap_increment = 4194304; Gc.space_overhead = 150; };
      (* enable Jacques-Henri Jourdan's statistical memory profiler
         (send SIGUSR1 to output results, which will create a
         memory_profile file). For more info:
         https://github.com/jhjourdan/ocaml/tree/memprof *)
      let () =
        let filename = Printf.sprintf "statistical-memprof-%d" (Unix.getpid ()) in
        let sampling_rate = try float_of_string (Sys.getenv "MEMPROF_SAMPLING_RATE") with _ -> 1E-4 in
        let callstack_size = try int_of_string (Sys.getenv "MEMPROF_CALLSTACK_SIZE") with _ -> 20 in
        let threshold = try int_of_string (Sys.getenv "MEMPROF_THRESHOLD") with _ -> 100 in
        MemprofHelpers.start filename sampling_rate callstack_size threshold
      in
      FStar_FStar.main ()
