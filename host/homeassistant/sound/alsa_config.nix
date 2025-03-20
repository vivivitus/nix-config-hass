{  
  sound.extraConfig = ''
    defaults.pcm.card 1
    defaults.ctl.card 1

    pcm.iqaudio {
            type hw
            card 1
            device 0
    }

    ctl.iqaudio {
            type hw
            card 1
            device 0
    }

    pcm.mix-play {
        type dmix
        ipc_key 1024
        ipc_perm 0666
        slave.pcm "iqaudio"
        slave {
            period_time 0
            period_size 1024
            buffer_size 4096
            channels 2 
        }
        bindings {
            0 0
            1 1
        }
    }

    pcm.mix-record {
        type dsnoop
        ipc_key 2048
        ipc_perm 0666 
        slave 
        {
            pcm "iqaudio"
            period_time 0
            period_size 1024
            buffer_size 4096
            rate 48000
            # format S16_LE
            channels 2
        }
        bindings {
            0 0
            1 1
        }
    }

    pcm.mix-record-plug {
        type plug
        slave {
            pcm "mix-record"
        }
    }

    pcm.duplex {
        type asym
        playback.pcm "mix-play"
        capture.pcm "dsnoop"
    }

    pcm.!default {
        type plug
        slave.pcm "duplex"
    }
  '';
}