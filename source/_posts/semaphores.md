---
title: Semaphores
date: 2024-10-16
tags: [concurrency, synchronization, low-level, c, c++, posix, linux, macos]
categories: [research, learning]
---

# Introduction

Semaphores are a synchronization primitive that can be used to protect shared resources. They are used to control access to shared resources by multiple threads or processes.

# Application

A resource shared across threads or across processes, e.g. a shared memory space, a file (descriptor), or a network socket, and you need to ensure that no more
than 1-n threads (or processes) should access at a time. This is where [semaphores](https://en.wikipedia.org/wiki/Semaphore_%28programming%29) come in.

# Mutex or Semaphore?

A mutex on the other hand is there to ensure that no more than one thread can access (to read or write) a shared resource at a time. It is akin to a binary semaphore.

Here's a comparison between the two as provided by ChatGPT:

| Feature                | Semaphore                                            | Mutex                                                  |
|------------------------|------------------------------------------------------|-------------------------------------------------------|
| **Purpose**            | Controls access to resources, allowing multiple threads to access (counting semaphore) or one (binary semaphore). | Ensures mutual exclusion, allowing only one thread to access a critical section. |
| **Counter**            | Maintains a count to track available resources.      | Binary state: locked or unlocked (no counter).        |
| **Ownership**          | No ownership; any thread can signal (release) a semaphore. | Ownership is enforced; only the thread that locks it can unlock it. |
| **Concurrency**        | Allows multiple threads to proceed if the counter is greater than 1 (in a counting semaphore). | Only one thread can proceed at a time.               |
| **Blocking Behavior**  | Threads block if the counter is zero (no available resources). | Threads block if the mutex is locked.                |
| **Use Cases**          | - Managing a pool of resources (e.g., thread pools, connection pools).<br>- Synchronizing producer-consumer workflows. | - Protecting critical sections.<br>- Ensuring exclusive access to shared data. |
| **Types**              | - Binary semaphore (similar to a mutex).<br>- Counting semaphore (allows multiple threads). | Only one type (binary lock).                         |
| **Risk of Deadlock**   | Higher risk if not used carefully (e.g., incorrect signaling order). | Lower risk due to strict ownership and locking rules. |
| **Performance**        | Slightly slower due to additional counter operations and flexibility. | Slightly faster because it enforces strict mutual exclusion. |
| **Platform Support**   | Available in most operating systems and threading libraries. | Available in most operating systems and threading libraries. |


For a very nice introduction to semaphores and their usage, [this post by Vikram Shukla](http://m.blog.chinaunix.net/uid-20341830-id-1701941.html) is a must-read.


# POSIX Semaphores

## Semaphore routines

An [overview of POSIX semaphore routines](https://man7.org/linux/man-pages/man7/sem_overview.7.html) is available via linux man pages.

## Linux vs MacOS

Interestingly, macOS does not support unnamed semaphores, [quora](https://www.quora.com/Why-does-OS-X-not-support-unnamed-semaphores).
So, if you are writing code that wants to comply with POSIX portability, you will need to use named semaphores.

