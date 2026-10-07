import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';
import { apiUrl, environment } from '@core/config/environment';
import { Product, ProductsResponse } from '../models/product.model';

@Injectable({ providedIn: 'root' })
export class ProductsService {
  private readonly http = inject(HttpClient);
  private readonly url = apiUrl(environment.endpoints.products);

  /** limit = 0 hace que dummyjson devuelva todo el catálogo */
  getProducts(limit = 0): Observable<Product[]> {
    const params = new HttpParams().set('limit', limit);
    return this.http.get<ProductsResponse>(this.url, { params }).pipe(map((r) => r.products));
  }
}
