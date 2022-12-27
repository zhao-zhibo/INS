function stext = labeldef(stext)
% Define special labels for conciseness.
% 
% Prototype: stext = labeldef(stext)
% Input: stext - a short text input
% Output: stext - corresponding fully formated text output

    specl = {...  % string cell
        'phi_degree',   '\it\phi\rm / ( \circ )';
        'phi',   '\it\phi\rm / ( \prime )';
        'phiE',  '\it\phi\rm_E / ( \prime\prime )';
        'phiN',  '\it\phi\rm_N / ( \prime\prime )';
        'phiU',  '\it\phi\rm_U / ( \prime )';
        'phiEN', '\it\phi \rm_{E,N} / ( \prime\prime )';
        'phix',  '\it\phi_x\rm / ( \circ )';
        'phiy',  '\it\phi_y\rm / ( \circ )';
        'phiz',  '\it\phi_z\rm / ( \circ )';        
        'phiroll',  '\it\phi roll\rm / ( \circ )';
        'phipitch',  '\it\phi pitch\rm / ( \circ )';
        'phiyaw',  '\it\phi yaw\rm / ( \circ )';        
        'phixy', '\it\phi _{x,y}\rm / ( \circ )';
        'mu',    '\it\mu \rm / ( \prime )';
        'mux',   '\it\mu_x \rm / ( \prime )';
        'muy',   '\it\mu_y \rm / ( \prime )';
        'muz',   '\it\mu_z \rm / ( \prime )';
        'theta', '\it\theta \rm / ( \prime )';
        'dVEN',  '\it\delta V \rm_{E,N} / ( m/s )';
        'dVE',   '\delta\it V \rm_E / ( m/s )';
        'dVN',   '\delta\it V \rm_N / ( m/s )';
        'dVU',   '\delta\it V \rm_U / ( m/s )';
        'dVD',   '\delta\it V \rm_D / ( m/s )';
        'dV',    '\delta\it V\rm / ( m/s )';
        'pr',    '\it\theta , \gamma\rm / ( \circ )';
        'ry',    '\it\gamma , \psi\rm / ( \circ )';
        'p',     '\it\theta\rm / ( \circ )';
        'r',     '\it\gamma\rm / ( \circ )';
        'y',     '\it\psi\rm / ( \circ )';
        'att',   '\itAtt\rm / ( \circ )';
        'datt',  '\itdAtt\rm / ( \prime )';
        'VEN',   '\itV \rm_{E,N} / ( m/s )';
        'VE',   '\itV \rm_E / ( m/s )';
        'VN',   '\itV \rm_N / ( m/s )';
        'VU',    '\itV \rm_U / ( m/s )';
        'V',     '\itV\rm / ( m/s )';
        'Vx',    '\itVx\rm / ( m/s )';
        'Vy',    '\itVy\rm / ( m/s )';
        'Vz',    '\itVz\rm / ( m/s )';
        'dlat',  '\delta\it L\rm / m';
        'dlon',  '\delta\it \lambda\rm / m';
        'dH',    '\delta\it H\rm / m';
        'dN',    '\delta\it N\rm / m';
        'dE',  '\delta\it E\rm / m';
        'dD',    '\delta\it D\rm / m';      
        
        'dP',    '\delta\it P\rm / m';
        'dP_latlon',    '\delta\it P\rm / \circ';
        'lat',   '\itL\rm / ( \circ )';
        'lon',   '\it\lambda\rm / ( \circ )';
        'hgt',   '\ith\rm / ( m )';
        'est',   '\itEast\rm / m';
        'nth',   '\itNorth\rm / m';
        'H',     '\itH\rm / m';
        'DP',    '\Delta\it P\rm / m';
        'ebyz',  '\it\epsilon _{y,z}\rm / ( (\circ)/h )';
        'eb',    '\it\epsilon\rm / ( (\circ)/h )';
        'en',    '\it\epsilon\rm / ( (\circ)/h )';
        'db',    '\it\nabla\rm / \mu\itg';
        'dKij',  '\delta\itKij\rm / (\prime\prime)';
        'dKii',  '\delta\itKii\rm / ppm';
        'Ka2',   'Ka2 / ug/g^2';
        'dbU',   '\it\nabla \rm_U / \mu\itg';
        'L',     '\itLever\rm / m';
        'dT',    '\delta\it T_{asyn}\rm / s';
        'dKg',   '\delta\it Kg\rm / ppm';
        'dAg',   '\delta\it Ag\rm / ( \prime\prime )';
        'dKa',   '\delta\it Ka\rm / ppm';
        'dAa',   '\delta\it Aa\rm / ( \prime\prime )';
		'wx',    '\it\omega_x\rm / ( (\circ)/s )';
		'wy',    '\it\omega_y\rm / ( (\circ)/s )';
		'wz',    '\it\omega_z\rm / ( (\circ)/s )';
		'w',     '\it\omega\rm / ( (\circ)/s )';
		'fx',    '\itf_x\rm / \itg';
		'fy',    '\itf_y\rm / \itg';
		'fz',    '\itf_z\rm / \itg';
		'f',     '\itf\rm / \itg';
		'dinst', '\delta\it\theta , \rm\delta\it\psi\rm / ( \prime )';
    };
    for k=1:size(specl,1)
        if strcmp(stext,specl(k,1))==1
            stext = specl{k,2};
            break;
        end
    end