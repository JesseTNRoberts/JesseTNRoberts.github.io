---
title: 'Is a Recursive Universal Function Approximator Necessarily Turing Complete?'
date: 2024-05-15
permalink: /posts/2024/05/15/Question/
tags:
  - question
---

Universal function approximation is unrelated to the computational expressivity of a computing model. Due to this it is unclear if universal function approximation coupled with recursion is necessarily sufficient to guarantee that a model is Turing complete. However, I believe that this is the case. Further, I believe it is provable.

The proof sketch is fairly simple and elegant. However, it warrants more consideration. A universal function approximator should be necessarily able to approximate any feedforward neural network, including an arbitrary RNN for a given time step and hidden state. The UFA can be recursively given access to the previous output and may be given the same input which would have been provided to the RNN. Therefore, it seems that any architecture that is capable of universal function approximation, when coupled with recursion, should be Turing complete.  
