#!bin/bash

usage()
{
	echo "Pour utiliser ce script : ./rp.sh -h"
}

cherche()
{
	echo "Voici le mode de recherche. Veuillez choisir un répertoire dans lequel travaillé :"
	read rep
	find $rep -name "*[<>:\|?*]*"

}

replace()
{
	echo "test rep"
	read rep
	find $rep -name "*[<>:\\|?*]*" -exec bash -c 'x="{}"; y="$(sed "s/[<>:\\|?*]\+/-/g" <<< "$x")" && mv "$x" "$y" ' \;

}

aled()
{
	echo "Voici l'aide de ce script."
	echo ""
	echo "afin d'utiliser le mode interactif, utilisez rp.sh -i c'est le mode permettant d'être assisté durant le processus de rennomage de fichier"
	echo ""
	echo "Pour rechercher un fichier : rp.sh -f"
	echo ""
	echo "Pour rennomer un fichier : rp.sh -r"
	echo ""
	echo "rp.sh -h affiche cette aide"
}

interactif()
{
	echo "Bienvenue dans le mode interactif que souhaitez vous faire ?"
	echo ""
	echo "Entrez f pour le mode de recherche de fichier à caractères illégaux"
	echo ""
	echo "Entrez r pour remplacer le nom des fichiers à caractères illégaux"
	echo ""
	echo "Entrez h peut simplement vous montrez comment utiliser ce script sans l'assistante interactive"
	read choice
	if [ $choice = "f" ];
	then
		cherche
	elif [ $choice = "r" ];
	then
		replace
	elif [ $choice = "h" ];
	then
		aled
	else
		echo "argument invalide veuillez réessayer."
		interactif
	fi
}


while getopts "ifrh" o; do
	case "${o}" in
		i)
			i=${OPTARG}
			interactif
			;;
		f)
			f=${OPTARG}
			cherche
			;;
		r)
			r=${OPTARG}
			replace
			;;
		h)
			h=${OPTARG}
			aled
			;;
	esac
done
shift $((OPTIND-1))

if [ -z "${i}" ] || [ -z "${f}" ]  [ -z "${r}" ] || [ -z "${h}" ]; then
usage
fi
