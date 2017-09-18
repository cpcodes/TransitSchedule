# TransitSchedule
NCTD OTC terminal signage for trains

Note that this is inherited code, and may contain code that has other copyrights. Additionally, the logos used in the displays are copyrighted by their respective owners.

This is mostly a stop-gap effort for station signage while we get an OBA implementation working and get a customized version of their sign app (or a from scratch version using the API) up and running, so modifications to this may be minimal going forward. There are numerous issues with the code as it stands, including egregious violation of DRY, way too much code in code-behind, and half implemented features (most notably NextBus integration), so it hurts my psyche to know that it exists, but there might not be any time or reason to continue with improving it. I've already done a fair amount of transitioning much of the visual elements to CSS so that more and more modification can be done without having to muck with the code. The code performs excruciatingly slowly, so I suspect there is too much DB access, but even so I can't imagine why it takes over a minute for the signage to come up. 

