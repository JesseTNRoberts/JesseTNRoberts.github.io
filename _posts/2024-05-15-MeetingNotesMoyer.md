---
title: 'Meeting with Moyer Colab'
date: 2024-05-15
permalink: /posts/2024/05/15/MeetingNotes/
tags:
  - Meeting notes
  - Idea
---



From the Program Director, it seems we need to ensure that we connect with a pressing need in the DEB portion of biology. Probably the ES side. On the computer science of the proposal, it needs to be clear how the virtuous cycle will play out. Specificaly, how will the data  force us to innovate in cs?

## How does satellite data for duck habitat (wintering and breeding) recognition force innovation in foundation models?

Satellite images are taken on the scale of days, creating a vast amount data. By merging that data with other GIS data (weather, topography, gps, and existing land use labels), we should be able to learn to do next frame prediction including how a given area of land changes given precipitation and nearby snow melt (pre-training task 1). In order to identify land that will be attractive in the coming season to animal populations, it's necessary to consider the present land state (to estimate snow melt induced water levels or calorie content) as well as the predicted future state. As the temporal distance to the season in question decreases, the fidelity of the model's prediction should increase. Such a model must be able to perform predictions at an arbitrary time scale. 

One method to achieve this would be to perform continual next frame prediction until the season in question is reached. However, this is limited by the temporal context length possible in the model. Further, iterative single step predictions has not been a successful method for predictions at an arbitrary distance in other domains. 

This creates an interesting and novel problem. The season in question is at a fixed point in the future but the temporal distance between the current frame and that point is a moving target. We believe a model can be trained to predict what a frame may look like on a given date based on the context provided without considering the temporal distance explicitly (pre-training task 2). As already mentioned, this should encourage the model to learn features that affect long term seasonal conditions whereas next frame prediction allows the model to learn to exploit short-term semantic connections. 

Such a model will learn a representation that is appropriate for near and far term predictions (learning interesting semantic connections between terrain, region, weather, climate, and land use). This is interesting and innovative from a foundation model perspective and is necessary to understand and animal habitat preferences. 

A model of this variety that merges large scale GIS data for prediction at arbitrarily prompted dates is not only of intellectual merit. This model is likely to have applicability to flood plain prediction, excavation/development effect prediction across multiple seasons (through counterfactual analysis), and use in climate change effect prediction.
