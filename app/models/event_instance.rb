class EventInstance < ActiveRecord::Base

  belongs_to :event
  belongs_to :user
  include UserNullable
  belongs_to :project

  serialize :participants

  scope :started, -> { where.not(hangout_url: nil) }
  scope :live, -> { where('updated_at > ?', 5.minutes.ago).order('created_at DESC') }
  scope :latest, -> { order('created_at DESC') }
  scope :pp_hangouts, -> { where(category: 'PairProgramming') }

  after_save "tweet_hangout_notification if (started? && hangout_url_changed?)"

  def started?
    hangout_url?
  end

  def live?
    started? && updated_at > 5.minutes.ago
  end

  def duration
    updated_at - created_at
  end

  def self.active_hangouts
    select(&:live?)
  end

  def start_datetime
    event != nil ? event.start_datetime : created_at
  end

  private

  def tweet_hangout_notification
    case self.category
    when 'Scrum'
      TwitterService.tweet("Scrum #{hangout_url} #scrum, #distributedteam")
    when 'PairProgramming'
      TwitterService.tweet("Pair programming on #{self.project.title} #{hangout_url} #pairwithme, #distributedteam")
    else
      Rails.logger.error "''#{self.category}'' is not a recognized event category for Twitter notifications. Must be one of: 'Scrum', 'PairProgramming'"
    end
  end
end
