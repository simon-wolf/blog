---
date: 2025-06-20 12:00
title: My Real Problem With AI
categories: miscellaneous
---

My day job is in technology. It is a mix of writing code and "managing stuff" in the technology-enabled care industry. And because I work in a technology field I have a lot of exposure to AI, whether I want it or not. And that's my real problem with AI.

Ignoring the moral issues of AI engines being fed or scraping source data to learn from, ignoring the potential problems of AI engines learning from each other and incorrect information becoming amplified, ignoring the stupid mistakes the AI engines make, the problem is that it is increasingly hard to not use AI.

As an example, I have a Windows 10 computer I need to use to update configurations on some hardware devices we use. Every time I boot it up I get presented with a window asking me to enable Copilot. There is a way to disable this but it's not easy and not something most users would be comfortable doing:

```
1. Press Win + R and type regedit in the Run box.
2. Navigate to the HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows key.
3. Right-click the Windows key in the left, and select New > Key from the menu.
4. Type WindowsCopilot for the new key name and hit Enter
5. Now, right-click the WindowsCopilot key you just created and select New > DWORD (32-bit) Value from its right-click menu.
6. Name the new value TurnOffWindowsCopilot and double-click it to change its value data.
7. Set its value to 1.
8. Sign out + sign in to apply the change. (or restarting, whatever works for you)
```

Why isn't there just a button saying "Disable Copilot"?

More and more tools that I use are adding AI but if you don't want to use AI then it's a seemingly constant game of whack-a-mole. And if you do opt-out is there any guarantee that your actions or data aren't being mined anyway? A [recent article](https://futurism.com/googles-ai-scraping-sites-opt-out) on one of those terrible websites that spew pop-ups and other nonsense everywhere tells me that Google will scrape sites which have opted out of being scraped. It all feels horribly shady and doesn't inspire confidence or trust about respecting privacy.

I'm very pleased that I started using Linux as my computer operating system a few years ago. I have a lot more control over what gets installed and how things are configured compared to a Windows or even macOS user and as applications I use start to introduce AI I can move to alternatives. Granted I'm using the command line more and this isn't going to work for an awful lot of people but it suits me as I get older and grumpier and reminisce about the "good old days" of computing.

