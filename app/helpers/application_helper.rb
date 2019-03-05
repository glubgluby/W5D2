module ApplicationHelper



    def authenticity
        "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
    end

    def checked?(id)
        if @post.sub_ids.include?(id)
            return "checked".html_safe
        end
        ""
    end

    def comments_hash(post)
        comments = Comment.where(post_id: post.id)
        res_hash = Hash.new {|hash, parent_id| hash[parent_id] = []}
        comments.each do |comment|
            res_hash[comment.parent_comment_id] << comment
        end
        res_hash
    end

    #place_comments(comments_hash(@post))

    def place_comments(hash, id = nil, deep = 1)
        res = []
        level = hash[id]
        return [] if level.empty?
        level.each do |comment|
            res << "<a href='#{comment_url(comment)}'>#{comment.author.username}:  </a>#{comment.body}<br>"
            res << (("<&nbsp>".html_safe)*deep)
            res += place_comments(hash, comment.id, (deep + 1))
        end
        res
    end
end
