---
date: 2025-04-30 12:00
title: Zwift And Garmin Connect Intensity Minutes
categories: [personal development]
tags: [zwift]
---

[Garmin Connect](https://connect.garmin.com/) tracks, amongst an awful lot of other things, intensity minutes. These are useful as a guideline about how much activity you are doing per week, particularly if you want to make sure you are hitting the [recommended guidelines](https://www.nhs.uk/live-well/exercise/physical-activity-guidelines-for-adults-aged-19-to-64/).

However I've noticed that intensity minutes were not being recorded when I was doing Zwift rides and I wanted to know why because I wasn't getting an accurate picture of how much activity I was doing each week unless I looked in [Strava](https://www.strava.com/).

And why not just use Strava? I could, but it is not my primary way of reviewing my health and fitness data so if I can get it all into Garmin Connect then that would be ideal.

## The Problem Visualised

On Monday I did two fairly brief Zwift rides to test some theories. The first ride was done without my Garmin Fenix recording a fitness activity and the second one was done whilst recording a bike ride activity.

As I expected, Garmin only credited me with intensity minutes for the second Zwift ride but I also noticed that my Fenix recorded a much lower hear rate during the first ride (where I pushed harder) compared to my other heart rate monitor -- 76 BPM vs 171 BPM.

<figure>
  <img src="/images/2025-04-30-garmin-connect-ride-one.png" alt="Heart rate around 76 BPM"/>
  <figcaption>Garmin Fenix heart rate data</figcaption>
</figure>

<figure>
  <img src="/images/2025-04-30-zwift-ride-one.jpg" alt="Heart rate around 171 BPM"/>
  <figcaption>Wahoo TICKR FIT heart rate data</figcaption>
</figure>

For the second ride, where my Fenix was recording an activity, the heart rate data on the watch was much closer to the external heart rate monitor -- 149 BPM vs 153 BPM.

<figure>
  <img src="/images/2025-04-30-garmin-connect-ride-two.png" alt="Heart rate around 149 BPM"/>
  <figcaption>Garmin Fenix heart rate data</figcaption>
</figure>

<figure>
  <img src="/images/2025-04-30-zwift-ride-two.jpg" alt="Heart rate around 153 BPM"/>
  <figcaption>Wahoo TICKR FIT heart rate data</figcaption>
</figure>

## Why?

Garmin are [up-front](https://support.garmin.com/en-US/?faq=pNU9nnDzzGAHmEavp9rpY8#ThirdPartyActivities) about the fact that you don't get intensity minutes from training apps or third-party activities (although you can get some due to the heart rate monitor in their wearable devices which might record enough data).

But why isn't my heart rate recorded properly when doing cycling? The Fenix should be getting heart rate readings and recording them properly.

A [Garmin forum discussion](https://forums.garmin.com/outdoor-recreation/outdoor-recreation/f/fenix-7-series/353413/fenix-7-pro-reported-way-too-low-hr-compares-to-hrm-dual-during-indooe-cycling/1701757#1701757) shed some light on it:

> The OHR [Optical Heart Rate] sensor has a low power mode for 24/7 tracking, and a high power mode for activities. (If you peek under the watch as you start an activity, you can see it change from strobing to solid On). The low power mode does pretty well for 24/7, but it does struggle when your HR get above 120 bpm.
> 
> Normally this is a non-issue, as Auto-Detect will pick up the wrist movements from walking, running, or outdoor cycling, etc. and trigger the high power mode. But indoor cycling is one of those unusual cases where because your wrists are almost motionless, Autodetect doesn't trigger the high power mode.

So the Fenix stays in a low power mode and this seems to mean it disregards unexpectedly high readings as well as taking readings only occasionally. There is [an article](https://sites.udel.edu/coe-engex/2020/03/07/how-garmin-watch-heart-rate-monitors-work/) about how the HRM monitors work but I confess to getting a bit bogged down in the details!

## The Solutions

Depending on the model, and my Fenix 7 is one of them, you can have your Garmin watch broadcast heart rate data. This also puts it into high power mode and allows it to record heart rate data accurately. But is is a big drain on the battery, particularly if you leave it on permanently.

I had thought that perhaps pairing an "external" heart rate monitor with my Fenix would get it to record intensity minutes properly but this doesn't work either. I tried it with my [Wahoo TICKR Fit](https://uk.wahoofitness.com/devices/running/heart-rate-monitors/tickr-fit-optical-heart-rate-monitor) armband.

I was going to try using a [Garmin HRM-Pro Plus](https://www.garmin.com/en-GB/p/770963) on the basis that it might solve the problem by recording your heart rate and feeding that directly into Garmin Connect but then [read a comment](https://forums.garmin.com/outdoor-recreation/outdoor-recreation/f/instinct-2-series/396283/instinct-solar-hrm-pro-plus-and-intensity-minutes#) in their forums which again implies that unless the watch is recording an activity it will ignore or "overwrite" the strap's heart rate data and not record intensity minutes (similar to what happens with a non Garmin-HRM).

So it seems that the easiest solution to my problem is to make sure I record an activity on my watch each time I do a Zwift ride. I don't need to save it but by having an activity running the watch goes into high power mode and records heart rate data properly which then generates intensity minutes. I just need to remember to do it before each ride.

If anyone has a better solution or can confirm that a Garmin HRM-Pro Plus will record activity minutes correctly then please do let me know [via email](mailto:simon@sgawolf.com).
