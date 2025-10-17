echo "Vienkāršā procenta kalkulators"
read -p "Ievadiet pamatsummu (EUR): " principal
read -p "Ievadiet likmi (% gadā): " rate
read -p "Ievadiet laiku (gadi): " time

# INPUT VALIDĀCIJA
if ! [[ "$principal" =~ ^[0-9]+(\.[0-9]+)?$ ]] || (( $(echo "$principal <= 0" | bc -l) )); then
    echo "KĻŪDA: Pamatsumma jābūt pozitīvam skaitlim"
    exit 1
fi

if ! [[ "$rate" =~ ^[0-9]+(\.[0-9]+)?$ ]] || (( $(echo "$rate <= 0" | bc -l) )); then
    echo "KĻŪDA: Likme jābūt pozitīvam skaitlim"
    exit 1
fi

if ! [[ "$time" =~ ^[0-9]+(\.[0-9]+)?$ ]] || (( $(echo "$time <= 0" | bc -l) )); then
    echo "KĻŪDA: Laiks jābūt pozitīvam skaitlim"
    exit 1
fi

# PAREIZS APRĒĶINS - tikai procentu daļa
interest=$(echo "scale=2; $principal * $rate / 100 * $time" | bc -l)
total=$(echo "scale=2; $principal + $interest" | bc -l)

echo "============================"
echo "Pamatsumma: €$principal"
echo "Likme: ${rate}% gadā"
echo "Laiks: $time gadi"
echo "============================"
echo "PROCENTU SUMMA: €$interest"
echo "KOPĀ AR PROVENTIEM: €$total"
