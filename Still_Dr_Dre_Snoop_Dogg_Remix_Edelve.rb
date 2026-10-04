# STILL :: Dr.Dre Snoop Dogg, remix by DJ_EDELVE - Sonic Pi #
# Ultra_Bass Idea (DJ_EDELVE)#

use_bpm 84
use_transpose 0.5
live_loop :drums, delay: 16 do
  sample :bd_tek, amp: 2, rate: 1.3, amp: 1; sleep 1
  sample :sn_dolf;  sleep 0.25
  sample :bd_tek, amp: 1;  sleep 0.25
  sample :bd_tek;  sleep 0.5
end

live_loop :boom, delay: 32 do
  sample :bd_sone, rate: 0.6, amp: 1.5, compress: 1
  sleep 4
end

with_fx :reverb, mix:  0.4, room:  0.85 do
  with_fx :ixi_techno do
    live_loop :kiribati, delay: 24 do
      synth [:pluck, :dtri].choose, release: [0.45, 0.85].ring.choose,
      amp: 0.4 if (spread 8, 11).tick
      sleep 0.25
    end
  end
end

with_fx :reverb, mix: 0.3, room: 0.5 do
  with_fx :compressor, pre_amp: 2 do
    live_loop :bass do 
      time = (ring 3, 1, 3, 1, 3, 1)
      synth :hollow, note:  (ring :a2, :b2, :e2, :e2).tick, amp: 1,
      attack: 0.05, sustain: 0.3, decay: 0.3, release: 3.2
      synth :hollow, note:  (ring :a1, :b1, :e1, :e1).look, amp: 0.5, cutoff: 129,
      attack: 0.05, sustain: 0.3, decay: 0.3,   release: 3.2
      sleep time.look
    end
  end

end
with_fx :reverb, mix: 0.5, room: 0.1 do
  with_fx :compressor, pre_amp: 1.2 do
    live_loop :strings, delay: 8 do   
      time = (ring 3, 1, 3, 1, 3, 1)  
      synth :dark_ambience, note:  (ring :a4, :a4, :g4, :r).tick,
      amp: 3, attack: 0.05, release: 1.5, pan: -0.75
      synth :dark_ambience, note:  (ring :a3, :a3, :g3, :r).look,
      amp: 3, attack: 0.05, release: 1.5, pan: 0
      synth :dark_ambience, note:  (ring :a3, :a3, :g3, :r).look,
      amp: 3, attack: 0.05, release: 1.5, pan: 0.75
      sleep time.look  
    end
  end
end

with_fx :reverb, mix: 0.4, room: 0.2 do
  with_fx :distortion, distort: 0.2 do
    live_loop :ultrabass, delay: 32 do
      tick
      use_transpose [-12, 0].choose
      dur = 2 ; a, b, c = 8*dur, 3*dur, 5*dur
      bass_line = (knit :a2, a, :b2, b, :e2, c)
      synth :fm, note: bass_line.look , divisor: 2, depth: 1, amp: 2,  
      release: 1.0/(dur*2) + 0.075 if (spread 5,7, rotate: 1).look  
      sleep 1.0/(2*dur)
    end
  end
end

with_fx :reverb, mix: 0.4, room: 0.88 do
  with_fx :bpf, centre: 100, pre_amp: 10 do
    live_loop  :piano do
      p = 1.0/3
      with_fx :ping_pong, mix: 0.1,  ## Mix for dry-wet signal
      phase: p, feedback: 0.5, pan_start: rdist(0.9, 0), reps: 16 do
        a, b, c = (chord :a4, :minor, invert: 1),
        ([:b4, :e5, :a5]),
        (chord :e4, :minor, invert: 2)

        synth :piano, note: (knit  a, 8, b, 3, c,5).tick, release: 0.5,
        sustain: 0.1, attack: 0.01, decay: 0.00, amp: 2
        sleep 0.5
      end
    end
  end
end
