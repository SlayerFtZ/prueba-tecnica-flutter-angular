import { OperatorFunction, catchError, map, of, startWith } from 'rxjs';
import { LoadState } from '../models/load-state';

export function toLoadState<T>(
  errorMessage: string,
  onError?: (message: string) => void,
): OperatorFunction<T, LoadState<T>> {
  return (source) =>
    source.pipe(
      map((data): LoadState<T> => ({ status: 'success', data })),
      catchError(() => {
        onError?.(errorMessage);
        return of<LoadState<T>>({ status: 'error', message: errorMessage });
      }),
      startWith<LoadState<T>>({ status: 'loading' }),
    );
}
