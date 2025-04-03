% Definir la función
f = @(x) x^3 - 13*x - 12;

% Valores iniciales
x0 = 4.5; x1 = 5.5; x2 = 5;

% Tolerancia y número máximo de iteraciones
tol = 1e-6;
max_iter = 100;

% Función para aplicar el método de Müller
function raiz = muller(f, x0, x1, x2, tol, max_iter)
    % Inicializar variables
    iter = 0;
    x_vals = [x0, x1, x2];
    fprintf(' Iteración  |   x0     |   x1     |   x2     |    x3 (raíz)  |    Error   \n');
    fprintf('---------------------------------------------------------------\n');
    
    while iter < max_iter
        % Calcular los valores de la función en los puntos actuales
        f0 = f(x0);
        f1 = f(x1);
        f2 = f(x2);
        
        % Calcular los coeficientes a, b, c para la parábola cuadrática
        h0 = x1 - x0;
        h1 = x2 - x1;
        delta0 = (f1 - f0) / h0;
        delta1 = (f2 - f1) / h1;
        d = (delta1 - delta0) / (h1 + h0);
        
        % Calcular la raíz usando la fórmula de Müller
        a = d;
        b = delta1 + h1 * a;
        c = f2;
        
        % Calcular las raíces cuadráticas
        disc = sqrt(b^2 - 4*a*c);
        if b > 0
            denom = b + disc;
        else
            denom = b - disc;
        end
        
        % Calcular el nuevo punto
        x3 = x2 - 2*c / denom;
        
        % Imprimir los valores de la iteración
        error = abs(x3 - x2);
        fprintf('   %d      |  %.6f  |  %.6f  |  %.6f  |  %.6f  |  %.6f\n', iter, x0, x1, x2, x3, error);
        
        % Verificar si la solución es lo suficientemente precisa
        if error < tol
            raiz = x3;
            return;
        end
        
        % Actualizar los puntos para la siguiente iteración
        x0 = x1;
        x1 = x2;
        x2 = x3;
        
        iter = iter + 1;
    end
    
    % Si no se alcanzó la tolerancia, se devuelve la última estimación
    raiz = x2;
    fprintf('Se alcanzó el máximo número de iteraciones\n');
end

% Llamada a la función con los valores iniciales
raiz = muller(f, x0, x1, x2, tol, max_iter);
fprintf('\nLa raíz estimada es: %.6f\n', raiz);
