class FunnelsController < ApplicationController
  def index
    @funnel= {}
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      # Find next monday
      start_wday = start_date.wday
      days_away_from_monday = 1 - start_wday
      days_away_from_monday += 7 if days_away_from_monday < 0
      start_date = start_date + days_away_from_monday.days
      end_of_week = start_date + 6.days
      while end_of_week <= end_date do
        @funnel["#{start_date.to_s}-#{end_of_week.to_s}"] = Applicant.where('created_at >= ? AND created_at < ?', start_date, end_of_week + 1.day)
          .group(:workflow_state)
          .select(:workflow_state).count
        start_date += 7.days
        end_of_week += 7.days
      end
    end

    respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
    end
  end

  private

  # generates a formatted version of the funnel for display in d3
  def formatted_funnel
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << {label: date, value: count}
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end
end
