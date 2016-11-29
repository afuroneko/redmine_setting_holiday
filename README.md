Redmine Setting Holidays Plugin
=======================

This is a redmine plugin that setting holidays.  
It will also be reflected in the calendar and Gantt chart.

Prerequisites
-------------

* Redmine 2.x

  Testing Environment  
    Redmine version     2.6.2.stable  
    Ruby version        2.1.5-p273 (2014-11-13) [i686-linux]  
    Rails version       3.2.21  

  Tested on only Japanese Language.


Installations
-------------

1. Copy into the plugins directory

    $ cp -rf redmine_setting_holiday REDMINE_ROOT/plugins

2. Install gems

    $ cd REDMINE_ROOT  
    $ bundle install

3. Run Rake task

    $ RAILS_ENV=production bundle exec rake redmine:plugins:migrate

4. Restart Redmine

