function ftoc
python3 -c "print(str(round(($argv[1] - 32) * 5.0 / 9, 1)) + '°C')"
end
