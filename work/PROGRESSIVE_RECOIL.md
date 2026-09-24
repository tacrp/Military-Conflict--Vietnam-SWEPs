# Progressive recoil

Future guns can opt in with these weapon stats:

```lua
SWEP.ProgressiveRecoilUp = 0.1
SWEP.ProgressiveRecoilRight = 0.05
```

Both default to zero. No current weapon enables them.

Each shot adds `BurstCount * stat` to its normal recoil. The counter holds the
number of preceding shots, so the first shot adds nothing, the second adds one
increment, and the third adds two. Values use the same units as ViewSlideRecoilUp
and ViewSlideRecoilRight. Horizontal growth increases the random left/right kick
amplitude; it does not force drift in one direction.

The addition follows hip/ADS interpolation and precedes category/All, bipod,
dual-wield and volley multipliers. Both normal and realistic shooting use the
result. It does not alter recoil animations, pushback or NPC aiming.

Growth is linear and uncapped, and follows the existing predicted BurstCount
reset rules. A volley counts as one firing event, not one event per projectile.
There is no separate recoil accumulator or recovery timer.

Offline check: `python work/test_progressive_recoil.py`.
