---
title: 'Meeting Notes Fisher Colab and Phd Work'
date: 2024-05-22
permalink: /posts/2024/05/09/MeetingNotesFisher
redirect_from: /posts/2024/05/ResearchJournal_3/
tags:
  - Meeting notes
---

_2024-05-22_

There is a proposed experiment to test for fan effects based on typicality effects.

Experiment tests Fisher and Langley theory
Experiment tests for ICL based fan effects and IWL fan effects
Unifies a cognitive effect across learning types in LLMs

## 2024-05-09

We discussed potential ideas for how to measure fan effects in language models. I proposed that we vary the number of category members given in the context to a language model and interrogate the presence of the elements. 

## The experiment

At some number of context members, the probability of absence given actual presence will tend toward the probability of absence given actual absence. That is... 

$$\begin{aligned}
p(absent|present) \approx p(absent|absent)
\end{aligned}$$

When this occurs, if the probability of correctly evaluating the presence of atypical category members is higher than for typical category members, this would be a language model specific variant of the fan effect. 


So, GPT-2 can be used with a population and a number of category items that are understood in terms of their typicality. The context can be filled to varying degrees (experimental variable 1). When the above probabilitic scenario occurs for the cohort of present typical items, the probability of presence of the atypical within context cohor should be measured. If the accuracy is higher for atypical than for typical when the context has reached the described probabilistic scenario, then GPT-2 is more readily able to retrieve atypical items within the context than typical items. Thus, a form of fan effects are present. 

## 2020-05-15


- Thinking about the theoretical idea of computational criticism and synthesizing the desiderata from the fisher and shin paper with the framework from stiny and gips has resulted in a new understanding of the important facets of computational criticism. Specifically, it has become clear that many of the desiderata are isomorphic restatements of larger problems in AI and cognitive science. As an example, fisher and shin say that a critic should possess an understanding of the medium specific formal characteristics. This should be interpreted to mean that the critical process which yields translation from artwork to latent description should be sensitive to a subset of the medium specific formal characteristics. The more general problem in AI is known as feature selection. Given a set of features, which of these features is important. In cognitive science the question is how does attention cause the features to be extracted from the background? A similar problem in computational criticism is the need to exclude information which is irrelevant. This is important from the standpoint of expertise in cognitive science as those who are experts tend to not be distracted by irrelevant information. This is interesting because it seems that computational criticism inherits from both AI and cognitive science in important ways. This should be the case as criticism is a behavior that arises from intelligent behavior. 
  
- It’s interesting to consider that creators and critics exist in a symbiotic relationship with one begging the existence of the other. If a musician releases an album, opinions will be developed regarding their music. On the other hand, if a specific taste seems to emerge from a society, a creator will quickly fill the need for further creation. Often the creator will act as the critic as well. Such is the case for most human artists, thus the cliche of being one’s own biggest critic. This leads to a bit of a chicken or egg question. In the creative ecosystem who is responsible for the impetus that leads to new creations? Creator or critic? The obvious answer may be to assume that the creator was to blame. However, consider that if Bach had possessed a different critical bias then he would have likely created something else to suit his taste. Therefore, it seems that a creator possesses a critical bias based on there internal reward circuitry which then guides their search for their next creation. So, the critic comes before the creation. This leads to questions about the possibility of using the creator critic pair to simulate emergent creativity. By allowing the critic to evolve, the creator will begin to evolve to meet the expectations of the critic thus resulting in emergent, novel creations. 

- From above, it seems that a creator is actually made of a creative component and critical component with the critical arising from the reward giving limbic system. However, the creator does not produce a written criticism. This does not make the critical process in the creator any less real. This suggests that the written criticism is not an intrinsic process to general criticism. Below is an alternative model of creativity and criticism which has the limbic/reward circuitry in yellow, the perception/state-of-the-world in green, the analytical/synthetic (search) portion of thought is in red, and finally the action is taken in blue. This connects well with current theories regarding reinforcement learning. 

- Consider that there is no environmental stimulus such that the existence of a critic is required. Creativity and criticism arise out of human nature naturally. Then a model of creativity should be a model which begs the existence of a critic. Or rather more likely, the existence of a critic begs the existence of a creator. ~ The model of a creator above would also explain the emergence of a formal critic as one that takes in another’s work as their initial condition. In this way a critic proper should be understood to be themselves, creators. What makes critics unique is that through abundant exposure to many works of art, their reward centers are among the most well informed in the society. Reward is given based on predictability and surprise, so they are the hardest to surprise and are the most aware of new developments on which an artist may draw. They are therefore, most well situated to appreciate the work of a contemporary artist. They are also expected produce a derivative work of art themselves in the form of a written criticism. Therefore, the model above may be a suitable framework with which to model agents to develop emergent creativity and criticism. ~  In reality there also exists an audience not only creators and critics. However, if all people (and thus all agents in this ecosystem) are fundamentally similar in their cognitive build, why are some gifted to be creators or critics while others are not? Certainly every person has an imagination which can conceive of great beauty. This should be understood to be a situation in which the agent above is able to supply a description to the effector in the model above which is beautiful. Those who are gifted to be creators are able to take the description in their mind and take actions through the effector which generate an artwork. When that artwork is observed by the creator’s receptor or by the other agent’s receptors they are rewarded either egocentrically or exocentrically. An agent which attempts to create but does not experience any reward is not likely to continue to create. These agents that are not rewarded learn to consume thus becoming part of the audience. When the audiences learns to consume the work of creators they are learning to reward the creator. In this way, those which are capable of producing egocentrically or exocentrically rewarding creations become creators. Those which can’t become the audience. Interestingly this also predicts that those which will be critics did not learn to stop creating suggesting that they themselves were most likely mildly successful at creating. 

- In the beginning stages of the society, creators must create for an egocentric reward, however as time goes on the development of an audience could provide an exocentric reward which is large enough to overwhelm the egocentric. These creators which become devoted to the exocentric reward may become fan service which fail to subvert their audiences expectations and rather only succeed in meeting them. Meeting the audiences expectations spells death to a creator as the primary reward delivered to the audience comes from them being able to predict most of the creation but not being able to predict it fully which ultimately results in the powerful better than expected reward prediction error.

- A reinforcement learning model built from this with agents that have different creative processes and different tastes based on past experience and predilection for surprise should offer interesting insights into how the various pieces interlock to bring about the various actors in the society (creator, critic, and audience). As well as why some creators who develop exocentric reward centers fail to continue to reward the audience and why creators who focus on the egocentric reward may die in obscurity as Van Gogh did.


## 2019-09-17

- Discussed the direction of research - Decided that the best place to start would be the Computational Critic
- For the submission deadline of ICCC develop proof of concept and write paper
- Was discussed that this is a good area as there has not been much done in this area and there are many low hanging fruits available

### Follow up items for next meeting
- Look into technologies that could be leveraged to cobble together an Auto-Critic (topic modeling, summarization systems, etc.)
- Build corpus of all ICCC papers


