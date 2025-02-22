package com.drumstore.web.services;

import com.drumstore.web.models.Post;
import com.drumstore.web.repositories.PostRepository;

import java.util.List;

public class PostService {
    private final PostRepository postRepository;

    public PostService() {
        this.postRepository = new PostRepository();
    }

    public List<Post> getLatestPosts(int limit) {
        return postRepository.getLatestPosts(limit);
    }
}