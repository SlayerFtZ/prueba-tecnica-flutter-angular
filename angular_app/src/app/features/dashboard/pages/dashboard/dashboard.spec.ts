import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { apiUrl, environment } from '@core/config/environment';
import { DashboardComponent } from './dashboard';

describe('DashboardComponent', () => {
  let httpMock: HttpTestingController;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DashboardComponent],
      providers: [provideHttpClient(), provideHttpClientTesting()],
    }).compileComponents();

    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => httpMock.verify());

  it('muestra los totales calculados a partir de la API', async () => {
    const fixture = TestBed.createComponent(DashboardComponent);
    await fixture.whenStable();

    httpMock
      .expectOne(apiUrl(environment.endpoints.carts))
      .flush({
        carts: [
          { id: 1, userId: 1, total: 100, discountedTotal: 80, totalProducts: 1, totalQuantity: 1, products: [] },
          { id: 2, userId: 2, total: 200, discountedTotal: 120, totalProducts: 1, totalQuantity: 1, products: [] },
        ],
        total: 2, skip: 0, limit: 30,
      });
    httpMock
      .expectOne((req) => req.url === apiUrl(environment.endpoints.products))
      .flush({ products: [], total: 0, skip: 0, limit: 0 });

    await fixture.whenStable();

    const text = (fixture.nativeElement as HTMLElement).textContent ?? '';
    expect(text).toContain('Pedidos');
    expect(text).toContain('2');
    expect(text).toContain('$200.00');
  });
});
