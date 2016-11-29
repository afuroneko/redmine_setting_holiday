require 'date'
require 'date/holiday'

module SettingHolidaysHelper
  def abbr_day_name(day)
    ::I18n.t('date.abbr_day_names')[day % 7]
  end

  def month_name(month)
    ::I18n.t('date.month_names')[month]
  end

  def link_to_prev_year(year, options={})
    target_year = year - 1
    name = "#{target_year}"

    # \xc2\xab(utf-8) = &#171;
    link_to_year(("\xc2\xab " + name), target_year, options)
  end

  def link_to_next_year(year, options={})
    target_year = year + 1
    name = "#{target_year}"

    # \xc2\xbb(utf-8) = &#187;
    link_to_year((name + " \xc2\xbb"), target_year, options)
  end

  def link_to_year(link_name, year, options={})
    link_to_content_update(h(link_name), params.merge(:year => year))
  end

  def get_holidays(project_id, year)
    now_year = Date.new(year, 1, 1)
    next_year = Date.new((year + 1), 1, 1)
    holidays = SettingHoliday.find(:all, :conditions => ["project_id = ? and date >= ? and date < ?", project_id, now_year, next_year], :order => "date ASC")
    holidays
  end

  def get_holiday_class(day, holidays)
    ret = ''
    if day.cwday == 6
      ret = ' sat'
    elsif day.cwday == 7
      ret = ' holi'
    elsif day.national_holiday?
      ret = ' holi'
    else
      for holiday in holidays
        if holiday.date == day
          ret = ' holi'
          break
        end
      end
    end

    ret
  end

  def check_holiday(day, holidays)
    ret = false
    for holiday in holidays
      if holiday.date == day
        ret = true
        break
      end
    end
    ret
  end
end
