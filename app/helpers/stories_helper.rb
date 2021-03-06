module StoriesHelper
  def turnoff_voting_button?(story)
    if cookies[:votes].present?
      cookie_array = YAML.load cookies[:votes]
      cookie_array.include? story.id
    elsif current_user
      story.user_voted?(current_user)
    end
  end

  def hide_story?(story)
    if story.total_point < Story::HIDE_THRESHOLD
      if current_page?(controller: "stories", action: "index") or
        current_page?(controller: "mypage", action: "index") or
        current_page?("/stories")
          return true
      end
    end
    return false
  end

  def positive_or_negative(vote)
    if vote.rating.weight >= 0
      "label-success"
    else
      "label-important"
    end
  end
end
