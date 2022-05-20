<?php

  setlocale(LC_ALL, "POSIX");
  setlocale(LC_TIME, "ru_RU.UTF-8");
  setlocale(LC_CTYPE, "ru_RU.UTF-8");
  setlocale(LC_COLLATE, "ru_RU.UTF-8");
  putenv("LANG=ru_RU.UTF-8");
  putenv("LC_ALL=ru_RU.UTF-8");
  //var_dump(setlocale(LC_ALL, 0));
  umask(027);

  $_SERVER["TMPDIR"] = sys_get_temp_dir();
  $_SERVER["ILB_SSLCACERTIFICATEFILE"] = "/etc/ssl/certs/ourCAbundle.crt";
  $_SERVER["HOME"] = "/var/lib/wwwrun";
  $_SERVER["REMOTE_USER"] = "user";
  // trigger_error(print_r($_SERVER,true));