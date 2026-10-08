import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';
import { apiUrl, environment } from '../../../core/config/environment';
import { Order, OrdersResponse } from '../models/order.model';

@Injectable({ providedIn: 'root' })
export class OrdersService {
  private readonly http = inject(HttpClient);
  private readonly url = apiUrl(environment.endpoints.carts);

  getOrders(): Observable<Order[]> {
    return this.http.get<OrdersResponse>(this.url).pipe(map((res) => res.carts));
  }

  getOrder(id: number): Observable<Order> {
    return this.http.get<Order>(`${this.url}/${id}`);
  }
}
