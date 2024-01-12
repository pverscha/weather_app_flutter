double fahrenheitToCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}

double convertInHgToHpa(double pressureInInHg) {
  const double conversionFactor = 33.8638866667;
  return pressureInInHg * conversionFactor;
}
