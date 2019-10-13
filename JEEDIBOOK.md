# Java/NodeJS Developer openSUSE setup

# Repos

Add repos for maven, svn 1.9 (NB 11.1 compatibility javahl), netbeans

```bash
zypper ar "https://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Leap_15.1/" "develtools"
zypper ar "http://download.opensuse.org/repositories/devel:/tools:/scm:/svn:/1.9/openSUSE_Leap_15.0/" "devel:tools:scm:svn:1.9"
zypper ar "http://download.opensuse.org/repositories/home:/Herbster0815/openSUSE_Leap_15.1/" "home:Herbster0815"
```

## Packages

```bash
sudo zypperr in \
psi+ \
stunnel \
java-11-openjdk java-11-openjdk-src java-11-openjdk-devel \
mysql-workbench \
subversion \
git \
maven \
netbeans
```

