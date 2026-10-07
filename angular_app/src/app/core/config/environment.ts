export const environment = {
  production: false,
  apiUrl: 'https://dummyjson.com',
  endpoints: {
    carts: '/carts',
    products: '/products',
  },
  messages: {
    loadOrdersError: 'No se pudieron cargar los pedidos.',
    loadOrderError: 'No se encontró el pedido.',
    loadProductsError: 'No se pudieron cargar los productos.',
    loadDashboardError: 'No se pudo cargar el resumen.',
  },
} as const;

export const apiUrl = (endpoint: string): string => `${environment.apiUrl}${endpoint}`;
