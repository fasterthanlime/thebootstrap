class MergeUrlWithText < ActiveRecord::Migration
  def change
    Feedback.all.select { |f| not f.url.empty? }.each do |f|
        f.content = f.content + "\r\n\r\n<#{f.url}>"
        f.save!
    end

    remove_column :feedbacks, :url
  end
end
