## add this to your .bashrc
## [ -f $HOME/work/norm/.bashrc ] && . $HOME/work/norm/.bashrc

## get machine id for later
MACHINEID="$HOSTNAME.${BASH_VERSINFO[5]}"
[ -z "${debian_chroot:-}" -a -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
[ -n "$debian_chroot" ] && MACHINEID+=".$debian_chroot"

NORMPREFIX="$HOME/norm.$MACHINEID"
DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

addpath() {
    [ -z "$1" -o -z "$2" ] && return
    local value VARNAME=$1
    shift
    for value; do
        [ -z "${!VARNAME}" ] && export $VARNAME="$value" && continue
        [[ ! "${!VARNAME}" =~ "(^|:)$value(:|$)" ]] && export $VARNAME="$value:${!VARNAME}"
    done
}

## add ourselves to the PATH if we're not there yet
addpath PATH "$DIR" "$NORMPREFIX/bin" "$NORMPREFIX/sbin" "$NORMPREFIX/bin/ccache_wrap"

unset -f addpath
