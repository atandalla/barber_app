final List<OnboardingPageData> pages = [
  OnboardingPageData(
    title: 'Barber Shop',
    description:
        'Administra tu barbería desde el celular. Agenda citas, vende productos y mantén el control total de tus servicios con una app rápida e intuitiva.',
    imageAsset: 'assets/images/barber-logo1.jpeg', // reemplaza por el lottie adecuado
  ),
  OnboardingPageData(
    title: 'Agenda y atiende sin complicaciones',
    description:
        'Permite que tus clientes reserven citas fácilmente. Organiza tu día con recordatorios, historial de servicios y atención personalizada.',
    imageAsset: 'assets/images/barber-logo2.png', // ícono de calendario o reservas
  ),
  OnboardingPageData(
    title: 'Ventas y productos en un solo lugar',
    description:
        'Vende productos de cuidado personal directamente desde la app. Controla tus ventas, stock y reportes como un profesional.',
    imageAsset: 'assets/images/barber-logo3.jpg', // logo de tu barbería o imagen representativa
  ),
];

  class OnboardingPageData {
  final String title;
  final String description;
  final String? imageAsset;
  final String? lottieAsset;

  const OnboardingPageData({
    required this.title,
    required this.description,
    this.imageAsset,
    this.lottieAsset,
  });
}
