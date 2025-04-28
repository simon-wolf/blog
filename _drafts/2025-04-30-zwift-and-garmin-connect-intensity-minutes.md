---
date: 2025-04-30 12:00
title: Zwift And Garmin Connect Intensity Minutes
categories: health
---

[Garmin Connect](https://connect.garmin.com/) tracks, amongst an awful lot of other things, intensity minutes. These are useful as a guideline about how much activity you are doing per week, particularly if you want to make sure you are hitting the [recommended guidelines](https://www.nhs.uk/live-well/exercise/physical-activity-guidelines-for-adults-aged-19-to-64/).

However I've noticed that intensity minutes were not being recorded when I was doing Zwift rides and I wanted to know why because I wasn't getting an accurate picture of how much activity I was doing each week unless I looked in [Strava](https://www.strava.com/). And why not just use Strava? I could but it is not my primary source of data and jumping between Garmin Connect and Strava seems less than ideal.

## The Problem Visualised

On Monday I did two fairly brief Zwift rides after work to test some theories. The first ride was done without my Garmin Fenix recording a fitness activity and the second one was done whilst recording a bike ride activity.

As I expected, Garmin only credited me with intensity minutes for the second Zwift ride but I also noticed that my Fenix recorded a much lower hear rate during the first ride (where I pushed harder) compared to my arm-strap heart rate monitor -- 76 BPM vs 171 BPM.

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

Garmin are [up-front](https://support.garmin.com/en-US/?faq=pNU9nnDzzGAHmEavp9rpY8#ThirdPartyActivities) about the fact that you don't get intensity minutes from training apps or third-party activities although you can get some due to the heart rate monitor in their wearable devices still recording data.

But why isn't my heart rate recorded properly when doing cycling? The Fenix should be getting heart rate readings and recording them properly.

A [Garmin forum discussion](https://forums.garmin.com/outdoor-recreation/outdoor-recreation/f/fenix-7-series/353413/fenix-7-pro-reported-way-too-low-hr-compares-to-hrm-dual-during-indooe-cycling/1701757#1701757) shed some light on it:

> The OHR [Optical Heart Rate] sensor has a low power mode for 24/7 tracking, and a high power mode for activities. (If you peek under the watch as you start an activity, you can see it change from strobing to solid On). The low power mode does pretty well for 24/7, but it does struggle when your HR get above 120 bpm.
> 
> Normally this is a non-issue, as Auto-Detect will pick up the wrist movements from walking, running, or outdoor cycling, etc. and trigger the high power mode. But indoor cycling is one of those unusual cases where because your wrists are almost motionless, Autodetect doesn't trigger the high power mode.

So the Fenix stays in a low power mode and just doesn't pick up and record higher heart rates because it's not expecting them and presumably treats them as some sort of anomaly. I have yet to read anything which properly and fully explains what is going on.

## The Solutions

An obvious solution to my problem seems to be to make sure I record an activity on my watch each time I do a Zwift ride. You don't need to save it, you can just use it to put the watch into high power mode to record heart rate data properly. This would be perhaps the simplest but I bet I won't always remember.

Depending on the model, any my Fenix 7 is one of them, you can have your Garmin watch broadcast heart rate data. This also puts it into high power mode and allows it to record heart rate data accurately. But is is a big drain on the battery, particularly if you leave it on and turning it on and off is even more complex than starting and stopping an activity.

A third option is to use a Garmin heart rate monitor and pair that with Garmin Connect so that its data effectively over-writes the data from the watch. This is probably the easiest one because if you are going to wear a heart rate monitor then why not use a Garmin one and solve the problem? Well possibly because you don't want to be completely tied in to the Garmin ecosystem, you already have a perfectly usable heart rate monitor or even price (Garmin kit is not cheap).

